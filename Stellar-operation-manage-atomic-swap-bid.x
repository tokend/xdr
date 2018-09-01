%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates or cancels an atomic swap bid

Threshold: med

Result: ManageAtomicSwapBidResult

*/

enum ManageAtomicSwapBidAction
{
    CREATE = 1,
    CANCEL = 2
};

struct CreateManageAtomicSwapBidData
{
    BalanceID baseBalance; // balance for base asset
    AssetCode quoteAsset;
    uint64 amount;
    uint64 price; // price of base asset in terms of quote
    uint64 fee;
    longstring details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageAtomicSwapBidOp
{
    union switch (ManageAtomicSwapBidAction action)
    {
    case CREATE:
        CreateManageAtomicSwapBidData creationData;
    case CANCEL:
        uint64 bidID;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ManageAtomicSwapBidResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1, // atomic swap bid does not exist
    INVALID_AMOUNT = -2, // amount is equal to 0
    INVALID_PRICE = -3, // price is equal to 0
    INVALID_DETAILS = -4,
    ATOMIC_SWAP_BID_OVERFLOW = -5,
    BASE_ASSET_NOT_FOUND = -6, // base asset does not exist
    QUOTE_ASSET_NOT_FOUND = -7, // quote asset does not exist
    BASE_ASSET_CANNOT_BE_SWAPPED = -8,
    QUOTE_ASSET_CANNOT_BE_SWAPPED = -9,
    BASE_BALANCE_NOT_FOUND = -10,
    ASSETS_ARE_EQUAL = -11, // base and quote assets are the same
    BASE_BALANCE_UNDERFUNDED = -12,
    INSUFFICIENT_FEE = -13
};

struct ManageAtomicSwapBidResultSuccess
{
    uint64 bidID;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

union ManageAtomicSwapBidResult switch (ManageAtomicSwapBidResultCode code)
{
case SUCCESS:
    ManageAtomicSwapBidResultSuccess success;
default:
    void;
};

}