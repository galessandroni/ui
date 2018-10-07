
UPDATE global SET 
    pub_web='http://pck.dev.local',
    admin_web='http://pckadmin.dev.local',
    install_key='b8f6cc18d38b5de1ab157ff6024eb4b5',
    title='PeaceLink Dev';

# Disable non-PeaceLink users
UPDATE users SET 
    active=0,
    login=CONCAT('user-',id_user),
    password='********',
    name=LCASE(LEFT(TO_BASE64(SHA(rand())),8)),
    email=CONCAT('user-',id_user,'@farlocco.it'),
    phone='',
    mobile=''
    WHERE email NOT LIKE '%@peacelink%';

UPDATE people SET 
    active=0,
    contact=0,
    password='********',
    name1=LCASE(LEFT(TO_BASE64(SHA(rand())),8)),
    name2=CONCAT('guest-',id_p),
    email=CONCAT('guest-',id_p,'@farlocco.it'),
    address='',
    phone='',
    token=''
    WHERE email NOT LIKE '%@peacelink%';

UPDATE topics SET domain='',newsletter=0;

TRUNCATE users_log;
TRUNCATE publish_log;
TRUNCATE queue;

UPDATE twitters SET active=0,oauth_token_secret='';
