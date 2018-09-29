package memes_online.model

import java.io.File

class Provider {
	
	File memes
	
	new() {
		this.memes = new File("memes")
	}
}
