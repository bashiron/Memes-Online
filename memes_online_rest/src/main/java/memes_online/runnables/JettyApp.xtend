package memes_online.runnables

import org.eclipse.jetty.server.Server
import org.eclipse.jetty.servlet.ServletContextHandler
import memes_online.server.JettyServer

class JettyApp {
	
	def static void main(String[] args) throws Exception {
		val server = new Server(9000)
		val handler = new ServletContextHandler(server, "/example")
		handler.addServlet(JettyServer, "/")
		server.start()
    }
	
}