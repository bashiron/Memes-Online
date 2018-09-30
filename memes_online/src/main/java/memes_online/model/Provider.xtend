package memes_online.model

import java.io.File
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardCopyOption

/**
 * Provee una interfaz para administracion basica sobre un directorio principal con el fin de generar memes y carpetas pero aun
 * mas importante conseguir memes dentro del directorio principal y subdirectorios.<p>
 * Trabaja sobre dos directorios en el sistema de archivos del SO: un directorio principal para almacenar memes y una papelera
 * o "purgatorio" donde los memes y carpetas son movidos antes de una limpieza de papelera, si esta es invocada.
 */
@Accessors
class Provider {
	
	File	memes
	File	papelera
	
	/**
	 * Contructor que se ubica en la carpeta de memes default y usa la papelera default.
	 */
	new() {
		this.memes = new File("C:\\Users\\user\\Downloads\\Luchi\\Memes")
		this.papelera = new File("C:\\Users\\user\\Desktop\\Papelera-java")
	}
	
	/**
	 * Contructor que define los paths recibidos como carpeta principal y carpeta papelera.
	 * Nota: los paths recibidos deben ser carpetas existentes, en caso de que alguno sea un archivo
	 * tira {@link NotFolderException}.<p>
	 * Si alguna carpeta no existe el funcionamiento del Provider es indefinido.
	 * @param	path_main	el path del directorio a ser usado como principal.
	 * @param	path_papelera	el path del directorio a ser usado como papelera.
	 */
	new(String path_main, String path_papelera) {
		val ubicacion = new File(path_main)
		val papelera = new File(path_papelera)
		if (ubicacion.isFile || papelera.isFile) {throw new NotFolderException} else {
			this.memes = ubicacion
			this.papelera = papelera
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
	
//	------------- LIMPIEZA -------------
	
	/**
	 * Prop: limpia de carpetas y memes el directorio principal.
	 */
	def void limpiarDirectorio() {
		for (File sub_file : memes.listFiles) {
			sub_file.eliminar						//Se borran las vacias y los memes
		}
		if (!carpetas(memes).empty) {
			for (File sub_file : memes.listFiles) {
				subCleanUp(sub_file)					//Recursion sobre las carpetas restantes
			}
		}
	}
	
	/**
	 * Prop: limpia de carpetas y memes la carpeta indicada.
	 */
	def private void subCleanUp(File carpeta) {
		for (File sub_file : carpeta.listFiles) {
			sub_file.eliminar						//Se borran las vacias y los memes
		}
		if (!carpetas(carpeta).empty) {
			for (File sub_file : carpeta.listFiles) {
				subCleanUp(sub_file)					//Recursion sobre las carpetas restantes
			}
		}
		carpeta.eliminar
	}
	
	/**
	 * Prop: mueve archivos a la papelera de reciclaje en vez de eliminarlos permanentemente.
	 */
	def void eliminar(File archivo) {
		mover(archivo,papelera.path)
	}
	
	/**
	 * CUIDADO - Una vez borrados los elementos de la papelera ya no se pueden recuperar.<p>
	 * Prop: limpia de carpetas y memes la papelera, haciendo recursion sobre sus carpetas.
	 */
	def limpiarPapelera() {
		for (File sub_file : papelera.listFiles) {
			sub_file.delete								//Se borran las vacias y los memes
		}
		if (!carpetas(papelera).empty) {
			for (File sub_file : papelera.listFiles) {
				cleanSubPapelera(sub_file)				//Recursion sobre las carpetas restantes
			}
		}
	}
	
	/**
	 * Prop: limpia de carpetas y memes la carpeta indicada, el borrado es permanente.
	 */
	def private void cleanSubPapelera(File carpeta) {
		for (File sub_file : carpeta.listFiles) {
			sub_file.delete							//Se borran las vacias y los memes
		}
		if (!carpetas(carpeta).empty) {
			for (File sub_file : carpeta.listFiles) {
				cleanSubPapelera(sub_file)				//Recursion sobre las carpetas restantes
			}
		}
		carpeta.delete
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
	 * Prop: cambia de directorio el archivo recibido hacia el path indicado.
	 * @param	archivo	el archivo a mover.
	 * @param	destino	el path del destino.
	 */
	def mover(File archivo, String destino) {
		Files.move(Paths.get(archivo.path), Paths.get(destino+"\\"+archivo.name), StandardCopyOption.REPLACE_EXISTING)
	}
	
}
