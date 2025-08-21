using CatalogService as service from '../../srv/cat-service';

annotate service.Books with @UI:{
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

annotate service.Books with {
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