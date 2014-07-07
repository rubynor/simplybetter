#widget.factory 'Idea', ['$resource', ($resource) ->
#  $resource '/widget_api/ideas.json', { token: _smplyBtr.appKey, user_email: _smplyBtr.email }
#]

#var appKey = _smplyBtr.appKey;
#var email = _smplyBtr.email;
#var name = _smplyBtr.name;

#/widget_api/ideas.json?token=BYGKGJYA&user_email=leirapp_superadmin@sbu.cc
#
#
#app.factory 'Booking', ($resource) ->
#  $resource '/backoffice/bookings.json'
#
#
#app.factory 'FixedpriceSearch', ($resource) ->
#  prices = $resource "/backoffice/companies/:company_id/fixed_prices/:id.json", {company_id: company_id, id: '@id'}, {update: {method: "PUT"}}
#
#  getPrices: (query_params, res_func) ->
#    prices.query(query_params, res_func)
#
#app.factory 'Fixedprice', ($resource) ->
#  $resource "/backoffice/companies/:company_id/fixed_prices/:id.json", {company_id: company_id, id: '@id'}, {update: {method: "PUT"}}
