/* eslint-disable */

/**
 * 此项目配置为方便新人使用，已缩减至最简配置。
 * 如若想使用更多功能，请查考文档中的 【3. config参数说明】 
 * 自行添加属性，以支持更多个性化功能
 */
const USER_CONFIG = {

  // 使用微信测试号：公众号APP_ID
  APP_ID: 'wxddcc96d1b72b2bc8',

  // 使用微信测试号：公众号APP_SECRET
  APP_SECRET: 'ff2c21a8136c1b36a812b2304cf97913',

  //PROVINCE: '江西',
  //CITY: '南昌市',

  PROVINCE: '北京',
  CITY: '北京',

  SWITCH : {
        /** 每日天气 */
    // 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    weather: false,

    /** 节假日 */
    // 下一休息日综合提醒, 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    holidaytts: true,

    /** 每日N句 */
    // 金山每日一句, 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    CIBA: false,
    
    // 每日一言, 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    oneTalk: false,
    
    // 土味情话(彩虹屁), 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    earthyLoveWords: false,
    
    // 朋友圈文案, 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    momentCopyrighting: false,
    
    // 毒鸡汤, 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    poisonChickenSoup: false,
    
    // 古诗古文, 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    poetry: false,

    /** 星座运势 */
    // 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    horoscope: true,
  
    /** 生日消息和节日消息 */
    // 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    birthdayMessage: true,
  
    /** 学生课表 */
    // 填 false 则不使用，按需关闭不使用的功能可以提高运行速度
    courseSchedule: false,
  },
  
  // Define the template IDs and user ID as global variables
  //TEMPLATE_ID: 'hgMxhD_lRtWtjh0BwpdELf_C7VeWdrBBnUFAs9I3W1s',
  //CALLBACK_TEMPLATE_ID: 'lwjuWEytjYUN0JYYvqkJAGbmoLTu6Q5h8HBkhne1mGQ',
  //USER_ID: 'oFOXb6QeNi5FKGYHK9guf-9i71AU',

  USERS: [
    {
      // 想要发送的人的名字
      name: 'ChronoWalker',
      // 使用微信测试号：扫码关注你的微信测试号后生成的一段字符串，在测试号后台能看到
      id: 'oFOXb6QeNi5FKGYHK9guf-9i71AU',
      // 使用微信测试号：你想对他发送的模板消息的模板ID
      //useTemplateId: 'hgMxhD_lRtWtjh0BwpdELf_C7VeWdrBBnUFAs9I3W1s',
      //useTemplateId: 'ZigcFRnS8Nmlz5hjTKRw9VIhFI_Q_gYFrMS5Pkl60ZY',
      useTemplateId: '_eSGfFkUx0OQR0MB9A0sFrS94JjMVYrB0z-nW12X6Uk',

      // 新历生日, 仅用作获取星座运势, 格式必须为MM-DD
      horoscopeDate: '06-15',
      festivals: [
        // 注意：此条配置日期为阴历日期，因为`type`中 “生日” 之前有 * 符号
        // {
        //   type: '*生日', nam: '宝贝', year: '1996', date: '06-15',
        // },
        // 注意：此条配置日期为阳历日期，因为`type`中 “生日” 之前没有 * 符号
        {
          type: '生日', name: '宝贝', year: '1996', date: '06-15',
        },
        {
           type: '节日', name: '今年', year: '2020', date: '01-01',
        },
      ],
      // 我们在一起已经有xxxx天了的配置
      customizedDateList: [
        { keyword: 'birth_date', date: '1996-06-15' },
        // 在一起的日子
        { keyword: 'love_day', date: '2022-09-08' },
        // 结婚纪念日
        { keyword: 'marry_day', date: '2022-09-09' },
      ],
    },
  ],


  // 【推送完成提醒】模板id, 用来看自己有没有发送成功的那个模板
  CALLBACK_TEMPLATE_ID: 'lwjuWEytjYUN0JYYvqkJAGbmoLTu6Q5h8HBkhne1mGQ',

  CALLBACK_USERS: [
    {
      name: '自己',
      // 使用微信测试号：自己的微信id，扫码关注你的微信测试号后生成的一段字符串，在测试号后台能看到
      id: 'oFOXb6QeNi5FKGYHK9guf-9i71AU',
    }
  ],

}

module.exports = USER_CONFIG

