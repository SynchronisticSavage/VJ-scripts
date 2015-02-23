# NOTE: this requires PyAudio because it uses the Microphone class
import speech_recognition as sr
r = sr.Recognizer()
with sr.Microphone() as source: # use the default microphone as the audio source
	audio = r.listen(source) # listen for the first phrase and extract it into audio data
	try:
		print("You said " + r.recognize(audio)) # recognize speech using Google Speech Recognition
	except LookupError:	# speech is unintelligible
		print("Could not understand audio")


