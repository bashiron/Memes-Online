package memes_online.runnables

import org.uqbar.xtrest.api.XTRest
import memes_online.server.RestfulServer
import memes_online.model.Provider

class App {
	
	def static void main(String[] args) {
		val provider = new Provider()
		XTRest.startInstance(9000, new RestfulServer(provider))
	}
}