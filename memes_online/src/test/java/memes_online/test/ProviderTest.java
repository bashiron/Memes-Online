package memes_online.test;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import memes_online.model.Provider;

public class ProviderTest {
	
	Provider provider;
	
	@Before
	public void setUp() {
		provider = new Provider();
	}

	@Test
	public void testCreacionSubCarpeta() {
		provider.crearSubcarpeta("prueba");
		assertTrue(provider.hayCarpeta("prueba"));
	}
	
}
