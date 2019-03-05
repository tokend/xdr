%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreateReference

    Add unique reference to database

    Threshold: high

    Result: CreateReferenceResult
*/

//: Is used to store:
//: * unique `reference` to core database
//: * unique `reference` and `meta` to horizon database
struct CreateReferenceOp
{
    //: Some unique string like hash etc.
    string64 reference;
    //: Stringified json object which contains fields
    longstring meta;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateReference Result ********/

//: Result codes of CreateReferenceOp
enum CreateReferenceResultCode
{
    //: `reference` successfully stored in code database
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Not allowed to pass empty reference
    INVALID_REFERENCE = -1,
    //: Not allowed to pass invalid json structure `meta`
    INVALID_META = -2,
    //: `reference` already exists in core database
    ALREADY_EXISTS = -3
};

//: Is used to pass success of CreateReferenceOp applying
struct CreateReferenceSuccessResult
{
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Is used to pass result of CreateReferenceOp applying
union CreateReferenceResult switch (CreateReferenceResultCode code)
{
    case SUCCESS:
        CreateReferenceSuccessResult success;
    default:
        void;
};

}