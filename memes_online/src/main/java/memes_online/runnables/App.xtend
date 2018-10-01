package memes_online.runnables

import memes_online.model.Provider

class App {
	
	def static void main(String[] args) {
		val provider = new Provider()
//		provider.limpiarDirectorio
//		provider.limpiarPapelera
//		System.out.println(meme)
		provider.crearMemeEn("\\uno\\dos", "gato.png")
	}
}
