PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX geoloc: <http://deductions.github.io/geoloc.owl.ttl#>

SELECT ?mobile (count(?DEPART) as ?points) WHERE {  GRAPH ?G {
      ?DEPART geoloc:mobile ?mobile .
} }
group by ?mobile
