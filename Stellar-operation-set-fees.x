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
        SET_FEES_SUCCESS = 0,
        
        // codes considered as "failure" for the operation
        SET_FEES_INVALID_AMOUNT = -1,      // amount is negative
		SET_FEES_INVALID_FEE_TYPE = -2,     // operation type is invalid
        SET_FEES_ASSET_NOT_FOUND = -3,
        SET_FEES_INVALID_ASSET = -4,
        SET_FEES_MALFORMED = -5,
		SET_FEES_MALFORMED_RANGE = -6,
		SET_FEES_RANGE_OVERLAP = -7,
		SET_FEES_NOT_FOUND = -8,
		SET_FEES_SUB_TYPE_NOT_EXIST = -9
    };
    
    union SetFeesResult switch (SetFeesResultCode code)
    {
        case SET_FEES_SUCCESS:
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
