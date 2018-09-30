package memes_online.model

import java.io.File
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Provider {
	
	File memes
	
	/**
	 * Contructor que se ubica en la carpeta de memes default.
	 */
	new() {
		this.memes = new File("C:\\Users\\user\\Downloads\\Luchi\\Memes")
	}
	
	/**
	 * Contructor que define el path recibido como carpeta principal.
	 */
	new(String path) {
		val ubicacion = new File(path)
		if (ubicacion.isFile) {throw new NotFolderException} else {
			this.memes = ubicacion
		}
	}
	
//	------------- RETORNO -------------

	/**
	 * Prop: busca un meme recursivamente segun <code>nombre</code> en la carpeta principal y devuelve el path en caso
	 * de que exista el meme.
	 * @param	nombre	nombre del archivo con extension (ejemplo: popuko.png).
	 */
	def dameMeme(String nombre) {
		return giveMeme(memes,nombre);
	}

	/**
	 * Prop: busca un meme recursivamente segun <code>nombre</code> en la carpeta indicada y devuelve el path en caso
	 * de que exista el meme.
	 * @param	carpeta	la carpeta donde buscar el meme.
	 * @param	nombre	nombre del archivo con extension (ejemplo: popuko.png).
	 */
	 def String giveMeme(File carpeta, String nombre) {
		var ret = "<NO HAY MEME>"
	 	val meme = getMeme(carpeta,nombre)
	 	if (meme !== null) {
		 	ret = meme
	 	} else {
	 		for (File folder : carpetas(carpeta)) {
	 			ret = giveMeme(folder, nombre)
	 		}
	 	}
	 	ret
	 }

	/**
	 * Prop: busca un meme segun <code>nombre</code> en la carpeta indicada y devuelve el path en caso de que exista el meme.<p>
	 * Nota: retorna null si no lo encuentra.
	 * @param	carpeta	la carpeta donde buscar el meme.
	 * @param	nombre	nombre del archivo con extension (ejemplo: popuko.png).
	 */
	def private getMeme(File carpeta, String nombre) {
		try {
			carpeta.listFiles.findFirst[it.file && it.name==nombre].path
		} catch (NullPointerException exception) {	//En caso de que no tenga subcarpetas.
			return null
		}
	}

	/**
	 * Prop: devuelve todos los archivos dentro de la carpeta principal.
	 */
	def archivos() {
		archivos(memes)
	}
	
	/**
	 * Prop: devuelve todos los archivos dentro de la carpeta indicada.
	 * @param	archivo	archivo donde buscar archivos
	 */
	def archivos(File archivo) {
		if (archivo.isFile) {
			throw new NotFolderException
		} else {
			archivo.listFiles.filter[it.file].toList
		}
	}
	
	/**
	 * Prop: devuelve todas las carpetas dentro de la carpeta principal.
	 */
	def carpetas() {
		carpetas(memes)
	}
	
	/**
	 * Prop: devuelve todas las carpetas dentro de la carpeta indicada.
	 * @param	archivo	archivo donde buscar carpetas.
	 */
	def carpetas(File archivo) {
		if (archivo.isFile) {
			throw new NotFolderException
		} else {
			archivo.listFiles.filter[it.directory].toList
		}
	}

//	------------- CREACION -------------
	
	/**
	 * Prop: crea una subcarpeta en la carpeta principal con el nombre indicado. Tambien crea las carpetas padre
	 * del path si no existen.
	 * @param	nombre	puede ser un nombre simple o un path estilo (..\\carpetaAbuelo\\carpetaPadre\\carpeta).
	 */
	def crearSubcarpeta(String nombre) {
		val sub = new File(memes.path + "\\" + nombre)
		sub.mkdirs
	}
	
	/**
	 * Prop: crea un meme con el nombre recibido en la carpeta principal.
	 */
	def crearMeme(String nombre) {
		val nuevo = new File(memes,nombre)
		nuevo.createNewFile
	}
	
//	/**
//	 * Prop: crea un meme con el nombre recibido en la ubicacion indicada en <code>path</code>.
//	 */
//	def crearMemeEn(String path, String nombre) {
//		
//	}
	
//	------------- OTROS -------------

	/**
	 * Prop: indica si hay una carpeta con el nombre indicado.
	 */
	def hayCarpeta(String nombre) {
		val carpetas = this.carpetas
		carpetas.exists[it.name==nombre]
	}
	
	/**
	 * Prop: indica si hay un meme con el nombre indicado.
	 */
	def hayMeme(String nombre) {
		val memes = this.archivos
		memes.exists[it.name==nombre]
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
	
	/**
	 * Prop: limpia de carpetas y memes el directorio principal.
	 */
	def void limpiarDirectorio() {
		cleanUp(memes)
		crearSubcarpeta("")		//Esto resucita el directorio principal.
	}
	
	/**
	 * Prop: limpia de carpetas y memes la carpeta indicada.
	 */
	def private void cleanUp(File carpeta) {
		for (File sub_file : carpeta.listFiles) {
			sub_file.delete							//Se borran las vacias y los memes
		}
		if (!carpetas(carpeta).empty) {
			for (File sub_file : carpeta.listFiles) {
				cleanUp(sub_file)					//Recursion sobre las carpetas restantes
			}
		}
		carpeta.delete
	}
	
}
