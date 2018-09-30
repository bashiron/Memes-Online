package memes_online.test;

import static org.junit.Assert.*;

import org.junit.*;

import memes_online.model.Provider;

public class ProviderTest {
	
	Provider	provider;
	
	String		meme1;
	String		meme2;
	String		carpeta1;
	
	@Before
	public void setUp() {
		meme1 = "memazo.jpg";
		meme2 = "menem.png";
		carpeta1 = "prueba";
		provider = new Provider();
	}
	
	@After
	public void tearDown() {
		provider.limpiarDirectorio();
	}
	
	@Test
	public void testConstructorEnArchivoTiraExcepcion() {
		//TODO
	}

	@Test
	public void testCreacionSubCarpeta() {
		provider.crearSubcarpeta(carpeta1);
		assertTrue(provider.hayCarpeta(carpeta1));
	}
	
	@Test
	public void testTearDown() {
		assertFalse(provider.hayCarpeta(carpeta1));		//Teniendo en cuenta el test de arriba
	}
	
	@Test
	public void testBuscarMeme() {
		provider.crearMeme(meme1);
		assertTrue(provider.hayMeme(meme1));
	}
	
	@Test
	public void testBuscarMemeRecursivo() {
		provider.crearMemeEn("\\primero\\segundo\\final", meme2);
		assertTrue(provider.existeMeme(meme2));
	}
	
	@Test
	public void testCrearMemeEnNuevaCarpeta() {
		assertFalse(provider.existeCarpeta(carpeta1));
		provider.crearMemeEn("\\padre\\" + carpeta1, meme1);
		assertTrue(provider.existeCarpeta(carpeta1));
	}
	
}
