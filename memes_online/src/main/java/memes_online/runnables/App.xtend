package memes_online.runnables

import memes_online.model.Provider

class App {
	
	def static void main(String[] args) {
		val provider = new Provider
		provider.crearArchivo("bashiron.jpg")
	}
}
