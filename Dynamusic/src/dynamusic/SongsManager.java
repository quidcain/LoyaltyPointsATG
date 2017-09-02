package dynamusic;

import atg.nucleus.GenericService;
import atg.repository.*;
import atg.repository.rql.RqlStatement;
import javax.transaction.TransactionManager;
import atg.repository.rql.*;
import javax.transaction.*;
import atg.dtm.*;


public class SongsManager extends GenericService {
	private Repository repository;
	private TransactionManager transactionManager;
	public SongsManager() {
		if (isLoggingDebug())
			logDebug("SongsManager constructor has been called");
	}

	public void deleteAlbumsByArtist(String pArtistId) throws RepositoryException {
		if (isLoggingDebug()) 
			logDebug("deleting albums by artist id " + pArtistId);
		MutableRepository mutRepos = (MutableRepository)getRepository();
		try {
			TransactionDemarcation td = new TransactionDemarcation();
			td.begin(getTransactionManager(), td.REQUIRED);
			try {
				/* First, find all the albums by this artist */
				RqlStatement findalbumsRQL = RqlStatement.parseRqlStatement("artist.id = ?0");
				RepositoryView albumView = mutRepos.getView("album");
				Object rqlparams[] = new Object[1];
				rqlparams[0] = pArtistId;
				RepositoryItem [] albumList = 
						findalbumsRQL.executeQuery (albumView, rqlparams);
				/* loop through the list, and delete the albums */
				if (isLoggingDebug())
					logDebug("found albums for artist: " + albumList);
				if (albumList != null) {
					for (int i = 0; i<albumList.length; i++) {
						if (isLoggingDebug()) 
							logDebug("deleting album " + albumList[i]);
						mutRepos.removeItem(albumList[i].getRepositoryId(), "album");
					} /* for loop on albumList */

					/*------ uncomment this code to test transactions/rollback ----*/
					/* throw new Exception("just a test, comment this out"); */

				} /* if albumList != null */
			} /* try block */     
			catch (Exception e) {
				if (isLoggingError())
					logError("Exception occured trying to remove albums", e); 
				try {
					getTransactionManager().setRollbackOnly();
				}
				catch (SystemException se) {
					if (isLoggingError())
						logError("Unable to set rollback for transaction", se);
				}
			}
			finally {
				td.end();
			} 
		}
		catch (TransactionDemarcationException e) {
			if (isLoggingError()) 
				logError("creating transaction demarcation failed, no albums deleted", e);
		}
	}


	public Repository getRepository() {
		if (isLoggingDebug())
			logDebug("getRepository has been called");
		return repository;
	}

	public void setRepository(Repository repository) {
		if (isLoggingDebug())
			logDebug("setRepository has been called");
		this.repository = repository;
	}

	public TransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(TransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

}
