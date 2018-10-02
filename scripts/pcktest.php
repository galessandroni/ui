<?php
$_SERVER['DOCUMENT_ROOT'] = realpath("scripts");
define('SERVER_ROOT',$_SERVER['DOCUMENT_ROOT']);

include_once(SERVER_ROOT."/../classes/phpeace.php");
include_once(SERVER_ROOT."/../classes/topics.php");
include_once(SERVER_ROOT."/../classes/topic.php");
include_once(SERVER_ROOT."/../classes/pagetypes.php");
include_once(SERVER_ROOT."/../classes/varia.php");
include_once(SERVER_ROOT."/../classes/queue.php");

// clear queue
$q = new Queue(0);
$q->JobsDeleteAll();

// reorganise content
$tt = new Topics();

function HomepageFeature($name,$id_group) {
  $pt = new PageTypes();
  $id_function = 1;
  $id_type = 0;
  $limit = 4;
  $id_feature = $pt->GlobalFeatureStore( 0,$name,"",$id_type,$id_function,0,0,1,0,0);
  $params = array();
  $params['limit'] = $limit;
  $params['id_topic_group'] = $id_group;
  $params['show_latest'] = 0;
  $params['with_content'] = 0;
  $params['sort_by'] = 0;
  $v = new Varia();
  $values = $v->Serialize($params);
  $pt->PageFunctionsParamsStore($id_feature,$values);
}

// 1 tematiche => pace
$id_pace = 1;
$tt->gh->GroupUpdate($id_pace, "Pace", "Pace", 0, 0, 1);
$tt->TopicUpdateGroup(41,$id_pace); // zanotelli
$tt->TopicUpdateGroup(19,$id_pace); // kosovo
$tt->TopicArchive(19);
$tt->TopicUpdateGroup(9,$id_pace); // tuttigiuperterra
$tt->TopicArchive(9);
$tt->TopicUpdateGroup(15,$id_pace); // boycottalaguerra
$tt->TopicArchive(15);
HomepageFeature("Pace",$id_pace);

// 6 portale => peacelink
$id_pck = 6;
$tt->gh->GroupUpdate($id_pck, "PeaceLink", "Associazione PeaceLink", 0, 0, 1);
$tt->TopicUpdateGroup(1,$id_pck); // editoriale
$tt->TopicUpdateGroup(3,$id_pck); // peacelink
$tt->TopicUpdateGroup(6,$id_pck); // links
$tt->TopicUpdateGroup(47,$id_pck); // emergenza
$tt->TopicArchive(47);
$tt->TopicUpdateGroup(5,$id_pck); // emergenza2
$tt->TopicArchive(5);
HomepageFeature("PeaceLink",$id_pck);

$t = new Topic(75); $t->Delete(); // peacelink.it

// 10 nodi
$id_nodi = 10;
$tt->gh->GroupUpdate($id_nodi, "Nodi", "I nodi di PeaceLink", 6, 0, 1);

// 3 campagne => cultura
$id_cultura = 3;
$tt->gh->GroupUpdate($id_cultura, "Cultura", "Cultura", 0, 0, 1);
$tt->TopicUpdateGroup(40,$id_cultura); // voltana
$tt->TopicUpdateGroup(82,$id_cultura); // laboratorio di scrittura
$tt->TopicUpdateGroup(16,$id_cultura); // cybercultura
$tt->TopicUpdateGroup(14,$id_cultura); // no brain
$tt->TopicUpdateGroup(36,$id_cultura); // storia della pace
$tt->TopicUpdateGroup(109,$id_cultura); // scuola
HomepageFeature("Cultura",$id_cultura);

// 11 ecologia
$id_eco = $tt->gh->GroupInsert("Ecologia", "Ecologia", 0, 1, "");
$tt->TopicUpdateGroup(31,$id_eco); // ecologia
$tt->TopicUpdateGroup(102,$id_eco); // green tour
$tt->TopicUpdateGroup(106,$id_eco); // processo ilva
$tt->TopicUpdateGroup(13,$id_eco); // consumocritico
$tt->TopicUpdateGroup(104,$id_eco); // economia
$tt->TopicUpdateGroup(42,$id_eco); // diritti animali
$tt->TopicUpdateGroup(99,$id_eco); // zeroipa
$tt->TopicUpdateGroup(105,$id_eco); // ecodidattica
HomepageFeature("Ecologia",$id_eco);

// 12 solidarieta'
$id_sol = $tt->gh->GroupInsert("Solidarietà", "Solidarietà", 0, 1, "");
$tt->TopicUpdateGroup(8,$id_sol); // palestina
$tt->TopicUpdateGroup(24,$id_sol); // latina
$tt->TopicUpdateGroup(11,$id_sol); // migranti
$tt->TopicUpdateGroup(61,$id_sol); // kimbau
$tt->TopicUpdateGroup(101,$id_sol); // legami di ferro
HomepageFeature("Solidarietà",$id_sol);

// 13 cittadinanza attiva
$id_citt = $tt->gh->GroupInsert("Cittadinanza attiva", "Cittadinanza attiva", 0, 1, "");
$tt->TopicUpdateGroup(107,$id_citt); // cittadinanza
$tt->TopicUpdateGroup(103,$id_citt); // citizen science
$tt->TopicUpdateGroup(34,$id_citt); // diritto in rete
$tt->TopicUpdateGroup(10,$id_citt); // mediawatch
$tt->TopicUpdateGroup(30,$id_citt); // sociale
$tt->TopicUpdateGroup(17,$id_citt); // genova
$tt->TopicArchive(17);
$tt->TopicUpdateGroup(38,$id_citt); // spronacoop
$tt->TopicArchive(38);
$tt->TopicUpdateGroup(49,$id_citt); // votantonio
$tt->TopicArchive(49);
HomepageFeature("Cittadinanza attiva",$id_citt);

// sort
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupReshuffle();
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(2, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(2, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(2, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(2, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(2, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(5, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(5, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(5, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(5, 0);

// make fotonotizia global
$pt = new PageTypes();
$pt->GlobalFeatureUpdate(10,7);

// publish
?>
