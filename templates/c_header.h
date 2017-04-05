/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * Project: MyProject 
 * 
 * Authors: Emanuel Regnath (emanuel.regnath@tum.de)
 *
 * Description: short
 * 
 * ToDo:
 * [ ] Implementation
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


#ifndef _MYMODULE_H_
#define _MYMODULE_H_

// system includes (<> search only in include paths)
#include <stdint.h>
// library includes
#include <libopencm3/cm3/nvic.h>
// own includes
#include "mymodule.h"


// ============================================================================
// defines
// ============================================================================
#define BRIGHTNESS_MAX 100


// ============================================================================
// types
// ============================================================================
typedef int Brightness_Type;  // 0 .. 100



// ============================================================================
// public functions
// ============================================================================

void LED_switchOn(void);  // use (void) if no parameters!!!



#endif
