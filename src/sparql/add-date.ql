PREFIX geoloc: <http://deductions.github.io/geoloc.owl.ttl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX dct: <http://purl.org/dc/terms/>

INSERT {
GRAPH ?G {
  ?POINT dct:date ?TIMESTAMP .
} }
WHERE { GRAPH ?G {
  ?POINT geoloc:mobile ?MOB .
  bind( STRDT( strafter( replace( str(?POINT), "point:/imei:", "") , "/" ), xsd:dateTime ) as ?TIMESTAMP )  
} }
