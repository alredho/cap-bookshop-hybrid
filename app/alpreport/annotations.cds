using CatalogService as service from '../../srv/cat-service';

annotate service.OrderItems with @(
    UI.Chart #sumQtyChart           : {
        $Type            : 'UI.ChartDefinitionType',
        ChartType        : #Bar,
        Title            : 'Total Quantity',
        Description      : 'Quantity Info',
        // Dimensions: [book_ID],
        Measures         : [quantity],
        MeasureAttributes: [
            {
                $Type  : 'UI.ChartMeasureAttributeType',
                Measure: quantity,
                Role   : #Axis1,
            }, 
        ],
    },
    UI.PresentationVariant #sumQtyPV: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: [
                         // '@UI.LineItem',
                        ![@UI.Chart#sumQtyChart],],
        Text          : 'Qty Sum'
    },
    UI.DataPoint #sumQtyDP          : {
        $Type: 'UI.DataPointType',
        Value: quantity
    },
    UI.KPI #KPIQuantity             : {
        $Type           : 'UI.KPIType',
        SelectionVariant: {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [{
                Text: 'Book ID',
                // PropertyName: book_ID,
                // Ranges      : [{
                //     Sign  : #I,
                //     Option: #NE,
                //     Low   : ''
                // }]
            }]
        },
        DataPoint       : ![@UI.DataPoint#sumQtyDP],
        Detail          : {DefaultPresentationVariant: ![@UI.PresentationVariant#sumQtyPV]}
    }

);
