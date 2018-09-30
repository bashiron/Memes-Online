package memes_online.server

import org.uqbar.xtrest.api.annotation.Controller
import memes_online.model.Provider

@Controller
class RestfulServer {
	
	Provider provider
	
	new(Provider provider) {
		this.provider = provider
	}
	
}