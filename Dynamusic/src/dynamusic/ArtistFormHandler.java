package dynamusic;

import java.io.IOException;

import javax.servlet.ServletException;

import atg.repository.servlet.RepositoryFormHandler;
import atg.droplet.*;
import atg.repository.*;
import atg.repository.servlet.*;
import atg.servlet.*;

public class ArtistFormHandler extends RepositoryFormHandler {
	private SongsManager songsManager;
	
	public ArtistFormHandler() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	protected void preDeleteItem(DynamoHttpServletRequest pRequest,
			DynamoHttpServletResponse pResponse) throws ServletException,
			IOException {
		try {
			songsManager.deleteAlbumsByArtist(getRepositoryItem().getRepositoryId());
		} catch (RepositoryException e) {
			if (isLoggingError())
                logError("Cannot delete albums by artist", e);
             addFormException(new DropletException("Cannot delete albums by artist"));
		}
	}

	public SongsManager getSongsManager() {
		return songsManager;
	}
	public void setSongsManager(SongsManager songsManager) {
		this.songsManager = songsManager;
	}

}
