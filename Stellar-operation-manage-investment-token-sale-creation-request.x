%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* ManageITSaleCreationRequestOp

    Creates, updates or removes investment token sale creation request

    Threshold: high

    Result: ManageITSaleCreationRequestResult
*/

enum ManageITSaleCreationRequestAction
{
    CREATE = 0,
    UPDATE = 1,
    CANCEL = 2
};

struct UpdateCreationRequestDetails
{
    uint64 requestID;
    InvestmentTokenSaleCreationRequest request;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageITSaleCreationRequestOp
{
    union switch (ManageITSaleCreationRequestAction action)
    {
    case CREATE:
        InvestmentTokenSaleCreationRequest request;
    case UPDATE:
        UpdateCreationRequestDetails updateDetails;
    case CANCEL:
        uint64 requestID;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ManageITSaleCreationRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0
};

struct ManageITSaleCreationRequestSuccess
{
    uint64 requestID;
    bool fulfilled;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

union ManageITSaleCreationRequestResult switch (ManageITSaleCreationRequestResultCode code)
{
    case SUCCESS:
        ManageITSaleCreationRequestSuccess success;
    default:
        void;
};

}