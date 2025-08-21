using CatalogService as service from '../../srv/cat-service';
using from '../../db/schema';

annotate service.OrderItems with @(
    UI.LineItem                               : [
        {
            $Type: 'UI.DataField',
            Value: ID,
            Label: 'ID',
        },
        {
            $Type: 'UI.DataField',
            Value: book_ID,
            Label: 'book_ID',
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: 'quantity',
        },
        {
            $Type: 'UI.DataField',
            Value: amount,
            Label: 'amount',
        },
    ],
    UI.SelectionFields                        : [book_ID, ],
    Aggregation                               : {
        ApplySupported           : {
            $Type                 : 'Aggregation.ApplySupportedType',
            AggregatableProperties: [
                {
                    $Type   : 'Aggregation.AggregatablePropertyType',
                    Property: amount,
                },
                {
                    $Type   : 'Aggregation.AggregatablePropertyType',
                    Property: quantity,
                },
            ],
            GroupableProperties   : [
                ID,
                book_ID
            ],
            Transformations       : [
                'aggregate',
                // 'topcount',
                // 'bottomcount',
                // 'identity',
                'concat',
                'groupby',
                'filter',
                'search'
            ],
        },
        CustomAggregate #amount  : 'Edm.Decimal',
        CustomAggregate #quantity: 'Edm.Int'
    },

    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
    UI.Chart #chartView : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Dimensions : [
            book_ID,
        ],
        Measures : [
            quantity,
            amount,
        ],
    },
    UI.SelectionPresentationVariant #chartView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.Chart#chartView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Chart View',
    },
) {
    amount    @Analytics.Measure  @Aggregation.default: #SUM  @Measures.ISOCurrency: currency_code;
    quantity  @Analytics.Measure  @Aggregation.default: #SUM  ;
    book      @Common.Text: book.title;
    currency  @Semantics.currencyCode;
};

annotate service.OrderItems with {
    book @Common.Label: 'book_ID'
};
