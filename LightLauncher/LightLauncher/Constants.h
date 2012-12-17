//
//  Constants.h
//  LightLauncher
//
//  Created by Huy Nguyen on 11/2/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#ifndef LightLauncher_Constants_h
#define LightLauncher_Constants_h

#define APP_NAME @"LightLauncher"

#define COMMAND_EMAIL @"email"
#define COMMAND_FACEBOOK @"facebook"
#define COMMAND_TWITTER @"twitter"

#define OPTION_SERVICE_TYPE @"service_type"
#define OPTION_SERVICE_NAME @"service_name"
#define OPTION_BODY @"body"
#define OPTION_URLS @"urls"
#define OPTION_TO_ADDRESSES @"to_addresses"
#define OPTION_CC_ADDRESSES @"cc_addresses"
#define OPTION_BCC_ADDRESSES @"bcc_addresses"
#define OPTION_SUBJECT @"subject"
#define OPTION_FILE_ATTACHMENTS @"file_attachments"
#define OPTION_IMAGE_ATTACHMENTS @"image_attachments"

#define OPTION_VALUE_PREFILL @"prefill"
#define OPTION_VALUE_PASTEBOARD @"pasteboard"

#define DISPLAY_NAME_PASTEBOARD_OPTION_VALUE @"from Pasteboard"

#define COMPONENTS_SEPARATOR @","

typedef enum {
    DATA_STRING,
    DATA_ARRAY,
} OptionDataType;

typedef enum {
    TYPE_BOOLEAN,
    TYPE_STRING,
    TYPE_EMAIL,
    TYPE_URL,
    TYPE_FILE,
    TYPE_IMAGE
} OptionValueType;

typedef enum {
    GROUP_CREATE,
    GROUP_HISTORY,
    GROUP_FAVORITE,
} ViewControllerGroup;

#endif
