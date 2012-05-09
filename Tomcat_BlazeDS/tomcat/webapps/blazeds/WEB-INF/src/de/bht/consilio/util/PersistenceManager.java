package de.bht.consilio.util;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public final class PersistenceManager {
    private static PersistenceManager instance = null;

    private PersistenceManager() {

    }

    public static PersistenceManager getInstance() {
	if (instance == null) {
	    instance = new PersistenceManager();
	}
	return instance;
    }

    public EntityManagerFactory createEntityManagerFactory() {
	return Persistence
		.createEntityManagerFactory("ideafactoryPersistenceUnit");
    }
}