sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'orderitems/test/integration/FirstJourney',
		'orderitems/test/integration/pages/OrderItemsList',
		'orderitems/test/integration/pages/OrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrderItemsList, OrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('orderitems') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrderItemsList: OrderItemsList,
					onTheOrderItemsObjectPage: OrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);