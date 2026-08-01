package com.messbill.JPAutil;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

	private static EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("dev");

    public static EntityManagerFactory getEmf() {
        return emf;
    }
}
