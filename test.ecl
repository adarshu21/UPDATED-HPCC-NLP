
import nlp from lib_nlp;

article := RECORD
  STRING title;
  // STRING id;
  STRING text;
  
  // UNSIGNED8 bytes {XPATH('@bytes')};
  // STRING space {XPATH('@xml:space')};
  
END;

articles := DATASET('~test::test::ans.xml',article,XML('xml/page'));
articles;


nlpResults := RECORD
  STRING title;
  STRING xmlEntities;
END;
  
nlpResults ExtractEntities(article L, INTEGER c) := TRANSFORM
  SELF.title := L.title;
  // SELF.xmlEntities := 'test';
  SELF.xmlEntities := nlp.AnalyzeText('afterlang',L.text);

END;

entities := PROJECT(articles,ExtractEntities(LEFT,COUNTER));
entities;




// personRec := RECORD
//   INTEGER articleID;
//   STRING name;
//   STRING event;
//   STRING title;
//   STRING affiliation;
//   STRING region;
//   STRING age;
//   STRING city;
//   STRING state;
//   STRING country;
// END;

// personRec extractPerson(nlpResults L) := TRANSFORM
//   SELF.articleID := L.id;
//   SELF.name := XMLTEXT('name');
//   SELF.event := XMLTEXT('event');
//   SELF.title := XMLTEXT('title');
//   SELF.affiliation := XMLTEXT('affiliation');
//   SELF.region := XMLTEXT('region');
//   SELF.age := XMLTEXT('age');
//   SELF.city := XMLTEXT('city');
//   SELF.state := XMLTEXT('state');
//   SELF.country := XMLTEXT('country');
// END;

// out := PARSE(entities, xmlEntities, extractPerson(LEFT), XML('people/person'));
// out;

