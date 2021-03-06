#' Get coordiante from address
#' Take in address and return the coordinate
#' @param address address
#' @param city the city of the address, optional
#' @param output should be "json" or "xml", the type of the result
#' @param formatted logical value, return the coordinates or the original results
#' @return A vector contains the  corresponding coordiante. If "formatted=TRUE", return the numeric coordinates, otherwise return json or xml type result, depents on the argument "output". If the length of address is larger than 1, the result is a matrix.
#' @export getCoordinate
#' @examples
#' 
#' \dontrun{ 
#' ## json output
#' getCoordinate('beijingdaxue')
#' 
#' ## xml output
#' getCoordinate('beijingdaxue', output='xml')
#' 
#' ## formatted
#' getCoordinate('beijingdaxue', formatted = T)
#' 
#' ## vectorization, return a matrix
#' getCoordinate(c('beijingdaxue', 'qinghuadaxue'), formatted = T)
#' }
#' 
getCoordinate = function(address, city=NULL, output='json', formatted = F){
    ### address
    if (grepl(' ', address)) warning('address should have balnk character!')
    address = gsub(' ', '', address)
    
    ### url
    url_head = paste0('http://api.map.baidu.com/geocoder/v2/?address=', address)
    if (!is.null(city)) url_head = paste0(url_head, "&city=", city)
    url = paste0(url_head, "&output=", output, "&ak=", map_ak)
    
    ### result
    result = getURL(url)
    names(result) = address
    
    ### transform data from json/xml
    trans = function(x, out = output){
        if (out == 'xml') {
            lat = gsub('.*?<lat>([\\.0-9]*)</lat>.*', '\\1', x)
            long = gsub('.*?<lng>([\\.0-9]*)</lng>.*', '\\1', x)
        }else if (out == 'json'){
            lat = gsub('.*?"lat":([\\.0-9]*).*', '\\1', x)
            long = gsub('.*?"lng":([\\.0-9]*).*', '\\1', x)
        }
        long = as.numeric(long); lat = as.numeric(lat)
        return(c("longtitude" = long, "latitude" = lat))
    }
    if (formatted) {
        if (length(result) > 1) {
            result = t(sapply(result, trans))
        } else {
            result = trans(result)
        }
    }
    
    ### final
    return(result)
}