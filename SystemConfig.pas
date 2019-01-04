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
  GBL_SYS_APPNAME: string = '淘管家';
  GBL_SYS_VERSION: string = ' 1.0 Beta';
  GBL_SYS_USERAGENT: string = 'Tao';
  GBL_SYS_UINIQID: string = 'N/A';  //机器唯一ID


  //环境配置
  CONF_DB_PASS: string = 'xiayijian!@#$';   //配置加密
  CONF_STARTUP: integer = 0; //是否随WINDOWS启动
  CONF_CLOSE_MIN: integer = 1; //关闭最小化
  CONF_CLOSE_TIP :Integer = 1; //关闭提醒对话框
  CONF_AUTO_LOGIN: integer = 1;  //自动登录
  CONF_DISCOUNT_MSG: integer = 1;  //折扣提醒
  CONF_MALL_MSG: integer = 1; //商城提醒
  CONF_AUTO_SYNC: integer = 1; //自动同步收藏夹
  CONF_AUTO_UPDATE: integer = 1; //自动升级
  CONF_AT_MSG: integer = 1;  //被@后的提醒
  CONF_RUNTIME: integer = 0; //运行次数
  CONF_IMPORT_COUNT: integer = 0; //导入收藏夹的次数

  CONF_TIMER_STAT: integer = 1200000; //20分钟间隔请求统计信息
  CONF_TIMER_MSG:  integer = 3600000;  //1小时执行1次请求用户私人消息等
  CONF_TIMER_SYNC: integer = 3600000; //1小时检测收藏夹

  //访问的URL
  DEF_URL_HOST: string = 'http://xiayijian.com';
  DEF_URL_MAIN: string = 'http://client.xiayijian.com/profile/my_favor_goods.php?id=0';
  DEF_URL_LOGIN: string = 'http://client.xiayijian.com/login.php';
  DEF_URL_LOGOUT: string = 'http://client.xiayijian.com/logout.php';
  DEF_URL_MSG: string = 'http://client.xiayijian.com/messagebox/index.php';

  //API接口调用地址---用户信息
  API_URL_USERINFO: string = 'http://api.xiayijian.com/user/get_userinfo_by_cookie';
  API_ID : integer = 1003;
  API_KEY: string = '6c244a74efc1256fd3d615cfb398c15b';
  API_USER_SIGN: string ='app_idlogin_keyuidusernameD3D06AD8C1C95E9E7202E3D1B96D735F';
  API_USER_TOCKEN: string = ''; //下一件的用户TOCKEN

  //用户消息数量
  API_USER_MSG_COUNT: integer = 0;

  //同步收藏夹URL地址
  API_URL_SYNC_FAVOR :string ='http://api.xiayijian.com/user/sync_favors';

  //获取同步进度API地址
  API_URL_SYNC_PROGRESS: string = 'http://api.xiayijian.com/user/get_sync_favor_progress';

  //获取升级接口地址
  API_URL_UPDATE:string = 'http://api.xiayijian.com/system/update';

  //统计接口
  API_URL_STAT:string = 'http://api.xiayijian.com/system/stat';


  //用户信息
  USER_ID: integer = 0;
  USER_NAME: string = 'N/A';
  USER_LOGIN_KEY :string = 'N/A';


  //升级公共变量信息
  UPDATE_APP_URL: string = '';
  UPDATE_APP_INFO: string = '';
  UPDATE_APP_VER: string = '1.0.0.0';



  DEF_INFO_FRAME:  Array [0..0] Of TExternalFrameInfo; //结构体数组

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
