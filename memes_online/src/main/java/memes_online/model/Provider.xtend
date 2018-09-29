package memes_online.model

import java.io.File
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Provider {
	
	File memes
	
	new() {
		this.memes = new File("C:\\Users\\user\\Downloads\\Luchi\\Memes")
	}
	
//	/**
//	 * Prop: busca un meme segun <code>nombre</code> y devuelve el path en caso de que exista el meme.
//	 * @param	nombre	nombre del archivo con extension (ejemplo: popuko.png)
//	 */
//	 def giveMeme(String nombre) {
//		//Busca en carpetas y subcarpetas el meme solicitado y lo guarda en "meme".
//	 	val meme = 
//	 	meme.
//	 }
	
//	------------- RETORNO -------------

	/**
	 * Prop: busca un meme segun <code>nombre</code> y devuelve el path en caso de que exista el meme.<p>
	 * Nota: solo busca en la carpeta padre. Retorna null si no lo encuentra.
	 * @param	nombre	nombre del archivo con extension (ejemplo: popuko.png)
	 */
	def getMeme(String nombre) {
		memes.listFiles.findFirst[it.file && it.name==nombre].path
	}

	/**
	 * Prop: devuelve todos los archivos.
	 */
	def archivos() {
		memes.listFiles.filter[it.file].toList
	}
	
	/**
	 * Prop: devuelve todas las carpetas.
	 */
	def carpetas() {
		memes.listFiles.filter[it.directory].toList
	}

//	------------- CREACION -------------
	
	/**
	 * Prop: crea una subcarpeta con el nombre indicado. Tambien crea las carpetas padre del path si no existen.
	 */
	def crearSubcarpeta(String nombre) {
		val sub = new File(memes.path + "\\" + nombre)
		sub.mkdirs
	}
	
	/**
	 * Prop: crea un archivo con el nombre recibido.
	 */
	def crearArchivo(String nombre) {
		val nuevo = new File(memes,nombre)
		nuevo.createNewFile
	}
	
//	------------- OTROS -------------

	/**
	 * Prop: indica si hay una carpeta con el nombre indicado.
	 */
	def hayCarpeta(String nombre) {
		val carpetas = this.carpetas
		carpetas.exists[it.name==nombre]
	}
	
	
	/**
	 * Prop: sustituye la carpeta padre por la carpeta ubicada en el path recibido.
	 */
	def cambiarCarpetaPadre(String path) {
		val nueva = new File(path)
		if (nueva.isFile) {
			throw new NotFolderException
		} else {
			memes = nueva
		}
	}
	
}
