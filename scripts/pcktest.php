<?php
$_SERVER['DOCUMENT_ROOT'] = realpath("scripts");
define('SERVER_ROOT',$_SERVER['DOCUMENT_ROOT']);

include_once(SERVER_ROOT."/../classes/phpeace.php");
$phpeace = new PhPeace();
echo $phpeace->Copyright();

// clear queue
include_once(SERVER_ROOT."/../classes/queue.php");
$q = new Queue(0);
$q->JobsDeleteAll();

// reorganise content
include_once(SERVER_ROOT."/../classes/topics.php");
include_once(SERVER_ROOT."/../classes/topic.php");
$tt = new Topics();

// 1 tematiche => pace
$tt->gh->GroupUpdate(1, "Pace", "Pace", 0, 0, 1);
$tt->TopicUpdateGroup(41,1); // zanotelli
$tt->TopicUpdateGroup(19,1); // kosovo
$tt->TopicArchive(19);
$tt->TopicUpdateGroup(9,1); // tuttigiuperterra
$tt->TopicArchive(9);
$tt->TopicUpdateGroup(15,1); // boycottalaguerra
$tt->TopicArchive(15);

// 6 portale => peacelink
$tt->gh->GroupUpdate(6, "PeaceLink", "Associazione PeaceLink", 0, 0, 1);
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupMove(6, 1);
$tt->gh->GroupMove(6, 1);
$tt->TopicUpdateGroup(1,6); // editoriale
$tt->TopicUpdateGroup(3,6); // peacelink
$tt->TopicUpdateGroup(6,6); // links
$tt->TopicUpdateGroup(47,6); // emergenza
$tt->TopicArchive(47);
$tt->TopicUpdateGroup(5,6); // emergenza2
$tt->TopicArchive(5);

$t = new Topic(75); $t->Delete(); // peacelink.it

// 10 nodi
$tt->gh->GroupUpdate(10, "Nodi", "I nodi di PeaceLink", 6, 0, 1);

// 3 campagne => cultura
$tt->gh->GroupUpdate(3, "Cultura", "Cultura", 0, 0, 1);
$tt->TopicUpdateGroup(40,3); // voltana
$tt->TopicUpdateGroup(82,3); // laboratorio di scrittura
$tt->TopicUpdateGroup(16,3); // cybercultura
$tt->TopicUpdateGroup(14,3); // no brain
$tt->TopicUpdateGroup(36,3); // storia della pace
$tt->TopicUpdateGroup(109,3); // scuola

// 11 diossina => ecologia
$tt->gh->GroupUpdate(11, "Ecologia", "Ecologia", 0, 0, 1);
$tt->TopicUpdateGroup(31,11); // ecologia
$tt->TopicUpdateGroup(102,11); // green tour
$tt->TopicUpdateGroup(106,11); // processo ilva
$tt->TopicUpdateGroup(13,11); // consumocritico
$tt->TopicUpdateGroup(104,11); // economia
$tt->TopicUpdateGroup(42,11); // diritti animali
$tt->TopicUpdateGroup(99,11); // zeroipa
$tt->TopicUpdateGroup(105,11); // ecodidattica

// 12 solidarieta'
$tt->gh->GroupInsert("Solidarietà", "Solidarietà", 0, 1, "");
$tt->TopicUpdateGroup(8,12); // palestina
$tt->TopicUpdateGroup(24,12); // latina
$tt->TopicUpdateGroup(11,12); // migranti
$tt->TopicUpdateGroup(61,12); // kimbau
$tt->TopicUpdateGroup(101,12); // legami di ferro

// 13 cittadinanza attiva
$tt->gh->GroupInsert("Cittadinanza attiva", "Cittadinanza attiva", 0, 1, "");
$tt->TopicUpdateGroup(107,13); // cittadinanza
$tt->TopicUpdateGroup(103,13); // citizen science
$tt->TopicUpdateGroup(34,13); // diritto in rete
$tt->TopicUpdateGroup(10,13); // mediawatch
$tt->TopicUpdateGroup(30,13); // sociale
$tt->TopicUpdateGroup(17,13); // genova
$tt->TopicArchive(17);
$tt->TopicUpdateGroup(38,13); // spronacoop
$tt->TopicArchive(38);
$tt->TopicUpdateGroup(49,13); // votantonio
$tt->TopicArchive(49);

$tt->gh->GroupReshuffle();

// publish
?>
