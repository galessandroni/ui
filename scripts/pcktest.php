<?php
$_SERVER['DOCUMENT_ROOT'] = realpath("scripts");
define('SERVER_ROOT',$_SERVER['DOCUMENT_ROOT']);

include_once(SERVER_ROOT."/../classes/phpeace.php");
include_once(SERVER_ROOT."/../classes/topics.php");
include_once(SERVER_ROOT."/../classes/topic.php");
include_once(SERVER_ROOT."/../classes/pagetypes.php");
include_once(SERVER_ROOT."/../classes/varia.php");
include_once(SERVER_ROOT."/../classes/queue.php");
include_once(SERVER_ROOT."/../classes/publishmanager.php");
include_once(SERVER_ROOT."/../classes/db.php");

// clear queue
$q = new Queue(0);
$q->JobsDeleteAll();

// reorganise content
$tt = new Topics();

function HomepageFeature($name,$id_group,$limit=4,$topic_limit=2) {
  $pt = new PageTypes();
  $id_function = 1;
  $id_type = 0;
  $id_feature = $pt->GlobalFeatureStore( 0,$name,"",$id_type,$id_function,0,0,1,0,0);
  $params = array();
  $params['limit'] = $limit;
  $params['id_topic_group'] = $id_group;
  $params['show_latest'] = 0;
  $params['with_content'] = 0;
  $params['sort_by'] = 0;
  $params['topic_limit'] = $topic_limit;
  $v = new Varia();
  $values = $v->Serialize($params);
  $pt->PageFunctionsParamsStore($id_feature,$values);
}

// 1 tematiche => pace
$id_pace = 1;
$tt->gh->GroupUpdate($id_pace, "Pace", "Tematiche e mailing list relative alla pace, al disarmo, ai conflitti, alla nonviolenza e ai diritti umani.", 0, 0, 1);
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
$tt->gh->GroupUpdate($id_pck, "PeaceLink", "Spazio web relativo all'Associazione PeaceLink e alle sue campagne.", 0, 0, 1);
$tt->TopicUpdateGroup(1,$id_pck); // editoriale
$tt->TopicUpdateGroup(3,$id_pck); // peacelink
$tt->TopicUpdateGroup(6,$id_pck); // links
$tt->TopicUpdateGroup(47,$id_pck); // emergenza
$tt->TopicArchive(47);
$tt->TopicUpdateGroup(5,$id_pck); // emergenza2
$tt->TopicArchive(5);
$tt->TopicUpdateGroup(60,$id_pck);
$tt->TopicUpdateGroup(83,$id_pck);
$tt->TopicUpdateGroup(50,$id_pck);
$tt->TopicUpdateGroup(86,$id_pck);
$tt->TopicUpdateGroup(100,$id_pck);
$tt->TopicUpdateGroup(108,$id_pck);
$tt->TopicArchive(108);
HomepageFeature("PeaceLink",$id_pck,4,1);

// 3 campagne => cultura
$id_cultura = 3;
$tt->gh->GroupUpdate($id_cultura, "Cultura", "Tematiche e mailing list relative alle forme di cultura di cui si interessa PeaceLink, dalla scuola, al cinema, alla musica, alla letteratura, alla cybercutura.", 0, 0, 1);
$tt->TopicUpdateGroup(40,$id_cultura); // voltana
$tt->TopicUpdateGroup(82,$id_cultura); // laboratorio di scrittura
$tt->TopicUpdateGroup(16,$id_cultura); // cybercultura
$tt->TopicUpdateGroup(14,$id_cultura); // no brain
$tt->TopicUpdateGroup(36,$id_cultura); // storia della pace
$tt->TopicUpdateGroup(109,$id_cultura); // scuola
HomepageFeature("Cultura",$id_cultura);

// 11 ecologia
$id_eco = $tt->gh->GroupInsert("Ecologia", "Tematiche e mailing list relative all'ecologia, all'educazione ambientale, allo sviluppo sostenibile e alla green economy", 0, 1, "");
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
$id_sol = $tt->gh->GroupInsert("Solidarietà", "Tematiche e mailing list relative alla costruzione di un mondo più giusto, accogliente, solidale, senza razzismi, barriere e pregiudizi.", 0, 1, "");
$tt->TopicUpdateGroup(8,$id_sol); // palestina
$tt->TopicUpdateGroup(24,$id_sol); // latina
$tt->TopicUpdateGroup(11,$id_sol); // migranti
$tt->TopicUpdateGroup(61,$id_sol); // kimbau
$tt->TopicUpdateGroup(101,$id_sol); // legami di ferro
HomepageFeature("Solidarietà",$id_sol);

// 13 cittadinanza attiva
$id_citt = $tt->gh->GroupInsert("Cittadinanza attiva", "Tematiche e mailing list relative alla tutela dei diritti e alla cittadinanza attiva in tutte le sue forme", 0, 1, "");
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

$tt->gh->GroupDelete(7);
$tt->gh->GroupDelete(10);

// ospiti
$tt->TopicUpdateGroup(7,2); // africanews
$tt->TopicUpdateGroup(48,2); // ostinati
$tt->TopicUpdateGroup(44,2); // superiori
$tt->gh->GroupDelete(9);
// pax christi
$tt->TopicUpdateGroup(22,2);
$tt->TopicUpdateGroup(20,2);
$tt->TopicUpdateGroup(25,2);
$tt->TopicUpdateGroup(90,2);
$tt->TopicUpdateGroup(91,2);
$tt->TopicUpdateGroup(92,2);
$tt->gh->GroupDelete(4);
// rete disarmo
$tt->TopicUpdateGroup(64,2);
$tt->TopicUpdateGroup(37,2);
$tt->TopicUpdateGroup(63,2);
$tt->TopicUpdateGroup(79,2);
$tt->TopicUpdateGroup(93,2);
$tt->TopicUpdateGroup(97,2);
$tt->TopicUpdateGroup(98,2);
$tt->gh->GroupDelete(8);
$tt->TopicArchive(7);
$tt->TopicArchive(48);
$tt->TopicArchive(44);
$tt->TopicArchive(54);
$tt->TopicArchive(46);
$tt->TopicArchive(26);
$tt->TopicArchive(32);
$tt->TopicArchive(59);
$tt->TopicArchive(58);
$tt->TopicArchive(29);
$tt->TopicArchive(77);
$tt->TopicArchive(70);
$tt->TopicArchive(81);
$tt->TopicArchive(84);
$tt->TopicArchive(85);
$tt->TopicArchive(95);

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
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(11, 0);
$tt->gh->GroupReshuffle();
$tt->gh->GroupMove(11, 0);
$tt->gh->GroupReshuffle();

// make fotonotizia global
$pt = new PageTypes();
$pt->GlobalFeatureUpdate(10,7);
$pt->ft->FeatureActiveSwap(8,false);

// deactive unused features
$pt->ft->FeatureActiveSwap(9,true);
$pt->ft->FeatureActiveSwap(11,true);
$pt->ft->FeatureActiveSwap(14,true);
$pt->ft->FeatureActiveSwap(15,true);
$pt->ft->FeatureActiveSwap(16,true);
$pt->ft->FeatureActiveSwap(17,true);
$pt->ft->FeatureActiveSwap(18,true);
$pt->ft->FeatureActiveSwap(19,true);
$pt->ft->FeatureActiveSwap(45,true);
$pt->ft->FeatureActiveSwap(46,true);
$pt->ft->FeatureActiveSwap(95,true);
$pt->ft->FeatureActiveSwap(107,true);
$pt->ft->FeatureActiveSwap(121,true);
$pt->ft->FeatureActiveSwap(128,true);
$pt->ft->FeatureActiveSwap(151,true);
$pt->ft->FeatureActiveSwap(183,true);
$pt->ft->FeatureActiveSwap(185,true);
$pt->ft->FeatureActiveSwap(190,true);

$pt->FeatureDelete(34,0,0);
$pt->FeatureDelete(35,0,0);
$pt->FeatureDelete(36,0,0);
$pt->FeatureDelete(71,0,0);

$db =& Db::globaldb();
$db->begin();
$db->lock( "features" );
$sqlstr = "UPDATE features SET public='1' WHERE id_feature='10' ";
$res[] = $db->query( $sqlstr );
$sqlstr = "UPDATE features SET active=1,public='1' WHERE id_feature='32' ";
$res[] = $db->query( $sqlstr );
Db::finish( $res, $db);
?>
