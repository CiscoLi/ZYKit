//
//  ClassSafeCategroyConfig.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/7.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

/*!
 *	@brief	可通过配置该文件来处理容错库中的打印信息
 */
#ifndef YRSnippets_YRClassSafeCategoryConfig_h
#define YRSnippets_YRClassSafeCategoryConfig_h

//若不想看到打印信息，可改为0,需要打印错误就改1
#define ENABLE_CLASS_SAFE_CATEGORY_LOG 1



#ifndef __OPTIMIZE__
#if ENABLE_CLASS_SAFE_CATEGORY_LOG
#define YRWarningLog(...) NSLog(__VA_ARGS__)
#else
#define YRWarningLog(...)
#endif
#else
#define YRWarningLog(...)
#endif

#endif
