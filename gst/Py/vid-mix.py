import gst, gobject
gobject.threads_init()

"""... ! videomixer name=mixer background=black ! xvimagesink"""

class MixPipe(gst.Pipeline):

    def add_videofile(self, filepath, alpha_value):
        src = gst.element_factory_make('filesrc')
	#src.set_property('location', '/home/hero/Videos/veejay/test.avi')
	#filepath = ('/home/hero/Videos/veejay/test.avi')
        src.props.location = args[0]
        decodebin = gst.element_factory_make('decodebin2')
        ffcol = gst.element_factory_make("ffmpegcolorspace")

        vscale = gst.element_factory_make('videoscale')

        alpha = gst.element_factory_make('alpha')
        alpha.props.alpha = alpha_value

        def pad_added(elem, pad, target):
            print "pad_added", pad, target
            if str(pad.get_caps()).startswith('video/'):
                elem.link(target)
                src.seek_simple(gst.FORMAT_TIME, gst.SEEK_FLAG_SEGMENT, 0)

        decodebin.connect('pad-added', pad_added, vscale)

        self.add(src, decodebin, ffcol, vscale, alpha)
        src.link(decodebin)
        gst.element_link_many(vscale, ffcol, alpha, self.mixer)

        return (src, alpha)

    def __init__(self, xid=None):
        gst.Pipeline.__init__(self)
        
        self.mixer = gst.element_factory_make("videomixer")
        self.mixer.set_property("background", "black")

        self.ffcol = gst.element_factory_make("ffmpegcolorspace")
        
        # XXX: bin abstraction for remaining sink/window logic
        self.sink = gst.element_factory_make("xvimagesink")
        self.sink.set_property("force-aspect-ratio", True)
        
        self.add(self.mixer, self.ffcol, self.sink)
        gst.element_link_many(self.mixer, self.ffcol, self.sink)
        
        if xid:
            self.xid = xid
            bus = self.get_bus()
            bus.enable_sync_message_emission()
            bus.connect('sync-message', self.on_sync_message)
            
    def on_sync_message(self, bus, message):
        if message.structure is None:
            return
        if message.structure.get_name() == 'prepare-xwindow-id':
            self.sink.set_xwindow_id(self.xid)
