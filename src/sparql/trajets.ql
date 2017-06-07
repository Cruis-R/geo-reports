PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX afn: <http://jena.hpl.hp.com/ARQ/function#>
PREFIX geoloc: <http://deductions.github.io/geoloc.owl.ttl#>
PREFIX dct: <http://purl.org/dc/terms/>

# Calcul distances des trajets pour un mobile donné <MOBILE>

# Calcul distance depuis point de départ donné (mobile forcément le même pour tous les points)
SELECT (sum(?DIST) as ?DISTANCE)
WHERE { GRAPH ?G {
    ?depart !geoloc:precedingPoint* ?POINT .
    ?POINT geo:lon ?LON ;
           geo:lat ?LAT .
    ?POINT_BEFORE geoloc:precedingPoint ?POINT .
    ?POINT_BEFORE geo:lon ?LON0 ;
                  geo:lat ?LAT0 .
    BIND( afn:sqrt( (?LON-?LON0)*(?LON-?LON0) + (?LAT-?LAT0)*(?LAT-?LAT0) ) AS ?DIST)


  # détection immobilisations pour un mobile donné <MOBILE>
  { SELECT ?depart (min(?TIMESTAMP) as ?BEGIN) (max(?TIMESTAMP) as ?END) ?LON ?LAT
    WHERE { GRAPH ?G {
      ?depart !geoloc:precedingPoint+ ?POINT .
      ?POINT geoloc:mobile <MOBILE> ;
        geo:lon ?LON ;
        geo:lat ?LAT ;  
        dct:date ?TIMESTAMP .
      ?POINT_BEFORE geoloc:precedingPoint ?POINT .
      ?POINT_BEFORE geo:lon ?LON0 ;
                    geo:lat ?LAT0 .
      FILTER( ?LON = ?LON0 && ?LAT = ?LAT0 )
    } }
  }
} }
