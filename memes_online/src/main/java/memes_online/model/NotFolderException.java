package memes_online.model;

public class NotFolderException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	public String getMessage() {
		return "No puede usarse un archivo";
	}
}
