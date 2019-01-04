unit SystemConfig;

interface

  uses PngImage;

{*******************************************************************************}
type
  TExternalFrameInfo=record
    Url:string;
    Target: integer;
    Width: integer;
    Height: integer;
    Title: WideString;
  end;

{*******************************************************************************}
var
  GBL_IS_LOGIN: Boolean = False;
  GBL_IS_EXIT: Boolean = False;
  GBL_SYS_APPNAME: string = '�Թܼ�';
  GBL_SYS_VERSION: string = ' 1.0 Beta';
  GBL_SYS_USERAGENT: string = 'Tao';
  GBL_SYS_UINIQID: string = 'N/A';  //����ΨһID


  //��������
  CONF_DB_PASS: string = 'xiayijian!@#$';   //���ü���
  CONF_STARTUP: integer = 0; //�Ƿ���WINDOWS����
  CONF_CLOSE_MIN: integer = 1; //�ر���С��
  CONF_CLOSE_TIP :Integer = 1; //�ر����ѶԻ���
  CONF_AUTO_LOGIN: integer = 1;  //�Զ���¼
  CONF_DISCOUNT_MSG: integer = 1;  //�ۿ�����
  CONF_MALL_MSG: integer = 1; //�̳�����
  CONF_AUTO_SYNC: integer = 1; //�Զ�ͬ���ղؼ�
  CONF_AUTO_UPDATE: integer = 1; //�Զ�����
  CONF_AT_MSG: integer = 1;  //��@�������
  CONF_RUNTIME: integer = 0; //���д���
  CONF_IMPORT_COUNT: integer = 0; //�����ղؼеĴ���

  CONF_TIMER_STAT: integer = 1200000; //20���Ӽ������ͳ����Ϣ
  CONF_TIMER_MSG:  integer = 3600000;  //1Сʱִ��1�������û�˽����Ϣ��
  CONF_TIMER_SYNC: integer = 3600000; //1Сʱ����ղؼ�

  //���ʵ�URL
  DEF_URL_HOST: string = 'http://xiayijian.com';
  DEF_URL_MAIN: string = 'http://client.xiayijian.com/profile/my_favor_goods.php?id=0';
  DEF_URL_LOGIN: string = 'http://client.xiayijian.com/login.php';
  DEF_URL_LOGOUT: string = 'http://client.xiayijian.com/logout.php';
  DEF_URL_MSG: string = 'http://client.xiayijian.com/messagebox/index.php';

  //API�ӿڵ��õ�ַ---�û���Ϣ
  API_URL_USERINFO: string = 'http://api.xiayijian.com/user/get_userinfo_by_cookie';
  API_ID : integer = 1003;
  API_KEY: string = '6c244a74efc1256fd3d615cfb398c15b';
  API_USER_SIGN: string ='app_idlogin_keyuidusernameD3D06AD8C1C95E9E7202E3D1B96D735F';
  API_USER_TOCKEN: string = ''; //��һ�����û�TOCKEN

  //�û���Ϣ����
  API_USER_MSG_COUNT: integer = 0;

  //ͬ���ղؼ�URL��ַ
  API_URL_SYNC_FAVOR :string ='http://api.xiayijian.com/user/sync_favors';

  //��ȡͬ������API��ַ
  API_URL_SYNC_PROGRESS: string = 'http://api.xiayijian.com/user/get_sync_favor_progress';

  //��ȡ�����ӿڵ�ַ
  API_URL_UPDATE:string = 'http://api.xiayijian.com/system/update';

  //ͳ�ƽӿ�
  API_URL_STAT:string = 'http://api.xiayijian.com/system/stat';


  //�û���Ϣ
  USER_ID: integer = 0;
  USER_NAME: string = 'N/A';
  USER_LOGIN_KEY :string = 'N/A';


  //��������������Ϣ
  UPDATE_APP_URL: string = '';
  UPDATE_APP_INFO: string = '';
  UPDATE_APP_VER: string = '1.0.0.0';



  DEF_INFO_FRAME:  Array [0..0] Of TExternalFrameInfo; //�ṹ������

  DEF_FORM_LOGIN_WIDTH: integer = 738;
  DEF_FORM_LOGIN_HEIGHT: integer = 410;

  DEF_FORM_MAIN_WIDTH: integer = 1026;
  DEF_FORM_MAIN_HEIGHT: integer = 727;

  DEF_FORM_MSG_WIDTH: integer = 764;
  DEF_FORM_MSG_HEIGHT: integer = 565;


  PngSettingOff, PngSettingOn, PngSettingDown, PngMinOn, PngMinOff,
  PngMinDown, PngCloseOn, PngCloseDown, PngCloseOff, PngTitle: TPngImage;

implementation



{*******************************************************************************}
end.
