package memes_online.test;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import memes_online.model.Provider;

public class ProviderTest {
	
	Provider	provider;
	
	String		meme1;
	String		meme2;
	
	@Before
	public void setUp() {
		meme1 = "memazo.jpg";
		meme2 = "menem.png";
		provider = new Provider();
	}
	
	@Test
	public void testConstructorEnArchivoTiraExcepcion() {
		//TODO
	}

	@Test
	public void testCreacionSubCarpeta() {
		provider.crearSubcarpeta("prueba");
		assertTrue(provider.hayCarpeta("prueba"));
	}
	
	@Test
	public void testBuscarMeme() {
		provider.crearMeme(meme1);
		assertTrue(provider.hayMeme(meme1));
	}
	
	@Test
	public void testBuscarMemeRecursivo() {
		provider.crearSubcarpeta("prueba\\prueba-cool");
//		provider.crearMeme("memazo.jpg");
		assertTrue(provider.dameMeme(meme2) != "<NO HAY MEME>");
	}
	
}
