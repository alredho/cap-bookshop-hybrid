using CatalogService as service from '../../srv/cat-service';

annotate service.Orders with @(
    UI         : {
        LineItem       : [
            {Value: OrderNo},
            {Value: buyer},
            {Value: total} 
        ],
        SelectionFields: [
            OrderNo,
            buyer
        ],
    },

    Aggregation: {ApplySupported: {
        $Type              : 'Aggregation.ApplySupportedType',
        GroupableProperties: [
            buyer,
            OrderNo
        ]
    },
        CustomAggregate #total: 'Edm.Decimal'
    }
);

annotate service.Orders with {
    total @Measures.ISOCurrency : currency_code @Analytics.Measure  @Aggregation.default: #SUM
};