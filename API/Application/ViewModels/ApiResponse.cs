using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Utilities.Constants;

namespace Application.ViewModels
{
    public class ApiResponse
    {
        #region Properties

        public string MessageCode { get; set; }

        public int StatusCode { get; set; }

        public object Data { get; set; }

        public int? TotalRow { get; set; }

        #endregion

        #region OK

        public static ApiResponse OK()
        {
            return new ApiResponse
            {
                StatusCode = ApiStatusCode.OK
            };
        }

        public static ApiResponse OK(object data, int? totalRow = null)
        {
            if (data is ICollection d)
            {
                totalRow = d.Count;
            }

            return new ApiResponse
            {
                StatusCode = ApiStatusCode.OK,
                Data = data,
                TotalRow = totalRow
            };
        }

        #endregion

        #region NotFound

        public static ApiResponse NotFound()
        {
            return new ApiResponse
            {
                StatusCode = ApiStatusCode.NotFound
            };
        }

        public static ApiResponse NotFound(string messageCode = null)
        {
            return new ApiResponse
            {
                MessageCode = messageCode,
                StatusCode = ApiStatusCode.NotFound
            };
        }

        #endregion

        #region BadRequest

        public static ApiResponse BadRequest(string messageCode = null)
        {
            return new ApiResponse
            {
                MessageCode = messageCode,
                StatusCode = ApiStatusCode.BadRequest
            };
        }

        #endregion

        #region Unauthorized

        public static ApiResponse Unauthorized()
        {
            return new ApiResponse
            {
                StatusCode = ApiStatusCode.Unauthorized
            };
        }

        #endregion

        #region Forbidden

        public static ApiResponse Forbidden()
        {
            return new ApiResponse
            {
                StatusCode = ApiStatusCode.Forbidden
            };
        }

        #endregion
    }
}
