package memes_online.server

import javax.servlet.http.HttpServlet
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.servlet.ServletException
import java.io.IOException
import org.eclipse.jetty.http.HttpStatus

class JettyServer extends HttpServlet {
	
	override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setStatus(HttpStatus.OK_200)
		resp.writer.println("EmbeddedJetty")
	}
	
}