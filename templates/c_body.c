/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * Institution: Technical University of Munich, Germany
 * Department:  Electrical and Computer Engineering 
 * Group:       Embedded Systems and Internet of Things
 * 
 * Project:     Hash-based Signature
 * Authors:     Emanuel Regnath (emanuel.regnath@tum.de)
 *
 * Description: Models a Merkle Tree
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


// system includes (<> search only in include paths)
#include <stdint.h>
// library includes
#include <libopencm3/cm3/nvic.h>
// own includes
#include "mymodule.h"


// ============================================================================
// defines
// ============================================================================


// ============================================================================
// private types
// ============================================================================


// ============================================================================
// private globals
// ============================================================================
int G_state;


// ============================================================================
// private prototypes
// ============================================================================
int saturate(int val, int min, int max);


// ============================================================================
// public function implementations
// ============================================================================
void LED_switchOn(void){
	
}


// ============================================================================
// private function implementation
// ============================================================================
int saturate(int val, int min, int max){
	if(val < min){ val = min; }
	if(val > max){ val = max; }
	return val;
}

