package memes_online.server

import org.uqbar.xtrest.api.annotation.Controller
import memes_online.model.Provider
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.http.ContentType

@Controller
class RestfulServer {
	
	Provider provider
	
	new(Provider provider) {
		this.provider = provider
	}
	
	@Get("/meme/:nombre")
	def conseguirMeme() {
		response.contentType = ContentType.
		return ok()
	}
	
}