/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * Institution: Technical University of Munich, Germany
 * Department:  Electrical and Computer Engineering 
 * Chair:       Embedded Systems and Internet of Things
 * 
 * Project:     Hash-based Signature
 * Authors:     Emanuel Regnath (emanuel.regnath@tum.de)
 *
 * Description: Models a Merkle Tree
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


// Header guard ==============================================================
#ifndef _MYMODULE_H_
#define _MYMODULE_H_


// Public includes ===========================================================

// system includes (<> search only in include paths)
#include <stdint.h>
// library includes
#include <libopencm3/cm3/nvic.h>
// own includes
#include "mymodule.h"


// Public types ==============================================================

// Public typedefs ===========================================================
typedef int Brightness_Type;  // 0 .. 100

// Public defines ============================================================
#define BRIGHTNESS_MAX 100

// Public constants ==========================================================

// Public function prototypes ================================================


void LED_switchOn(void);  // use (void) if no parameters!!!


// Header guard ==============================================================
#endif
