using { sap.capire.bookshop as my } from '../db/schema';

service CatalogService {
    @readonly
    entity Books   as projection on my.Books;

    @readonly
    entity Authors as projection on my.Authors;

    @readonly
    entity Orders     as projection on my.Orders;
}

annotate CatalogService.Books with @UI:{
    LineItem  : [
        {Value: title},
        {Value: descr, Label: 'Description'},
        {Value: genre_ID, Label: 'Genre'},
        {Value: author_ID, Label: 'Author'},
        {Value: stock},
        {Value: price},
        {Value: currency_code},

    ],
    SelectionFields  : [
        title,
        stock,
        genre_ID,
        price,
        currency_code
    ],
};

annotate CatalogService.Books with {
    author @Common: {
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Authors',
            Parameters: [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'author',
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
            ]
        },
        Text     : author.name,
        TextArrangement : #TextOnly,    
    }
};

annotate CatalogService.Orders with @(
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

annotate CatalogService.Orders with {
    total @Measures.ISOCurrency : currency_code @Analytics.Measure  @Aggregation.default: #SUM
};

annotate CatalogService.OrderItems with @(
    UI         : {
        LineItem       : [
            {Value: ID},
            {Value: book_ID},
            {Value: quantity},
            {Value: amount}

        ],PresentationVariant #table: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem'],
            Text: 'Table'
        },

        Chart #chart1 : {
            $Type     : 'UI.ChartDefinitionType',
            ChartType : #Column,
            Dimensions: [book_ID],
            Measures  : [
                quantity,
                amount
            ]
        },
        PresentationVariant #chart: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.Chart#chart1'],
            Text: 'Chart'
        },
        SelectionFields: [book_ID],
    },
    Aggregation: {
        ApplySupported           : {
            $Type              : 'Aggregation.ApplySupportedType',
            GroupableProperties: [
                ID,
                book_ID
            ],
            AggregatableProperties: [
                {Property: quantity},
                {Property: amount}
            ],
                        Transformations       : [
                'aggregate',
                'topcount',
                'bottomcount',
                'identity',
                 'concat',
                 'groupby',
                 'filter',
                 'search'
            ]
        },
        CustomAggregate #amount  : 'Edm.Decimal',
        CustomAggregate #quantity: 'Edm.Int'
    }
) {
    amount    @Analytics.Measure  @Aggregation.default: #SUM  @Measures.ISOCurrency: currency_code;
    quantity  @Analytics.Measure  @Aggregation.default: #SUM;
    book  @Common.Text: book.title
};
