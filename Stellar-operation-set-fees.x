// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-fee.h"

namespace stellar
{
    
    /* SetFeesOp
     
     Creates, updates or deletes fees
     
     Threshold: high
     
     Result: SetFeesEmissionRequestResult
     */
    struct SetFeesOp
    {
        FeeEntry* fee;
		bool isDelete;
		// reserved for future use
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    };

    /******* SetFeesEmissionRequest Result ********/
    
    enum SetFeesResultCode
    {
        // codes considered as "success" for the operation
        SUCCESS = 0,
        
        // codes considered as "failure" for the operation
        INVALID_AMOUNT = -1,      // amount is negative
		INVALID_FEE_TYPE = -2,     // operation type is invalid
        ASSET_NOT_FOUND = -3,
        INVALID_ASSET = -4,
        MALFORMED = -5,
		MALFORMED_RANGE = -6,
		RANGE_OVERLAP = -7,
		NOT_FOUND = -8,
		SUB_TYPE_NOT_EXIST = -9
    };
    
    union SetFeesResult switch (SetFeesResultCode code)
    {
        case SUCCESS:
            struct {
				// reserved for future use
				union switch (LedgerVersion v)
				{
				case EMPTY_VERSION:
					void;
				}
				ext;
			} success;
        default:
            void;
    };
    
}
