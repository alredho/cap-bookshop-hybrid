using { sap.capire.bookshop as my } from '../db/schema';

service CatalogService {
    @readonly
    entity Books   as projection on my.Books;

    @readonly
    entity Authors as projection on my.Authors;

    @readonly
    entity Orders as projection on my.Orders;

    @readonly
    entity OrderItems as projection on my.OrderItems;
}



