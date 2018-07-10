$firme_cartacee = 95000;

function CampaignSigners(campaignId,divId) {
            campaignUrl = '/js/signatures_js.php?id=' + campaignId;
            $.getJSON(campaignUrl, function(data) {
                        output = 'Firme complessive oltre ' + $firme_cartacee;
                        $('<div/>', {
                        'class': 'campaign-signers-' + campaignId,
                        html: output
                        }).appendTo(divId);
            });
}


