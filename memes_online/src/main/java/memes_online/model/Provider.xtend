package memes_online.model

import java.io.File
import java.util.List
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
	 * Nota: el path recibido debe ser una carpeta existente, en caso de que sea un archivo tira {@link NotFolderException}.<p>
	 * Si la carpeta no existe el funcionamiento del Provider es indefinido.
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
	 * de que exista el meme.<p>
	 * Nota: devuelve "{@literal <}NO HAY MEME{@literal >}" si no lo encuentra.
	 * @param	nombre	nombre del archivo con extension (ejemplo: popuko.png).
	 */
	def dameMeme(String nombre) {
		return giveMeme(memes,nombre);
	}

	/**
	 * Prop: busca un meme recursivamente segun <code>nombre</code> en la carpeta indicada y devuelve el path en caso
	 * de que exista el meme.<p>
	 * Nota: devuelve "{@literal <}NO HAY MEME{@literal >}" si no lo encuentra.
	 * @param	carpeta	la carpeta donde buscar el meme.
	 * @param	nombre	nombre del archivo con extension (ejemplo: popuko.png).
	 */
	 def String giveMeme(File carpeta, String nombre) {
		var ret = "<NO HAY MEME>"
	 	val meme = getMeme(carpeta,nombre)
	 	if (meme !== null) {
		 	ret = meme
	 	} else {
	 		val resultados = newArrayList
	 		for (File folder : carpetas(carpeta)) {
	 			resultados.add(giveMeme(folder, nombre))
	 		}
	 		ret = recolectarResultados(resultados)
	 	}
	 	ret
	 }
	
	/**
	 * Prop: interpreta la lista de resultados recibidos por la busqueda recursiva y devuelve el resultado final.
	 */
	def private String recolectarResultados(List<String> resultados) {
		val filtrado = resultados.filter[it != "<NO HAY MEME>"].toList	//Quita los indicadores de que no se encontro el meme.
		if (!filtrado.empty) {
			return filtrado.get(0)
		} else {
			return "<NO HAY MEME>"
		}
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
	 * Prop: busca una carpeta recursivamente segun <code>nombre</code> en la carpeta principal y devuelve el path en caso
	 * de que exista la carpeta.<p>
	 * Nota: devuelve "{@literal <}NO HAY CARPETA{@literal >}" si no la encuentra.
	 * @param	nombre	nombre de la carpeta a buscar.
	 */
	def dameCarpeta(String nombre) {
		//TODO
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
	
	/**
	 * Prop: crea un meme con el nombre recibido en la ubicacion indicada en <code>path</code>. Si la ubicacion no existe crea
	 * las carpetas necesarias.
	 * @param	path	es relativo a la carpeta principal, o sea que puede ser del estilo(\\subPrincipal\\carpetaNueva).
	 * @param	nombre	nombre del archivo a crear con extension (ejemplo: popuko.png).
	 */
	def crearMemeEn(String path, String nombre) {
		crearSubcarpeta(path)
		val nuevo = new File(memes.path + "\\" + path,nombre)
		nuevo.createNewFile
	}
	
//	------------- EXISTENCIA -------------

	/**
	 * Prop: indica si hay una carpeta con el nombre indicado en el primer nivel del directorio principal.
	 */
	def hayCarpeta(String nombre) {
		hayCarpeta(memes,nombre)
	}
	
	/**
	 * Prop: indica si hay una carpeta con el nombre indicado en el primer nivel de la carpeta indicada.
	 * @param	carpeta	la carpeta donde buscar.
	 * @param	nombre	la carpeta que se desea encontrar.
	 */
	def hayCarpeta(File carpeta, String nombre) {
		val carpetas = this.carpetas(carpeta)
		carpetas.exists[it.name==nombre]
	}
	
	/**
	 * Prop: busca una carpeta recursivamente en el directorio principal y subcarpetas.
	 */
	def existeCarpeta(String objetivo) {
		lookUpFolder(memes,objetivo)
	}
	
	/**
	 * Prop: busca una carpeta recursivamente en la carpeta indicada y subcarpetas.
	 */
	def private boolean lookUpFolder(File carpeta, String objetivo) {
		hayCarpeta(carpeta,objetivo) || lookUpSubFolders(carpeta,objetivo)
	}
	
	/**
	 * Prop: busca una carpeta recursivamente en las subcarpetas de la carpeta indicada.
	 */
	def private boolean lookUpSubFolders(File carpeta, String objetivo) {
		var cadena = false
		for (File sub_folder : carpetas(carpeta)) {
			cadena = cadena || lookUpFolder(sub_folder,objetivo)
		}
		return cadena
	}
	
	/**
	 * Prop: indica si hay un meme con el nombre indicado en el primer nivel del directorio principal.
	 */
	def hayMeme(String nombre) {
		hayMeme(memes,nombre)
	}
	
	/**
	 * Prop: indica si hay un meme con el nombre indicado en el primer nivel de la carpeta indicada.
	 */
	def hayMeme(File carpeta, String nombre) {
		val memes = this.archivos(carpeta)
		memes.exists[it.name==nombre]
	}
	
	/**
	 * Prop: indica si existe un meme del nombre indicado buscando recursivamente en el directorio principal y subcarpetas.
	 */
	def existeMeme(String nombre) {
		dameMeme(nombre) != "<NO HAY MEME>"
	}
	
//	------------- OTROS -------------
	
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
