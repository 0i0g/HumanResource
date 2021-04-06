using Application.Interfaces;
using Application.RequestModels;
using Application.ViewModels;
using Data.Entities;
using Data.Enum;
using Data_EF;
using Data_EF.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities.Constants;

namespace Application.Implementations
{
    public class OTService : BaseService, IOTService
    {
        private IOTRequestRepository _OTRequestRepository;
        private IUserRepository _userRepository;
        private ISystemRepository _systemRepository;

        public OTService(IUnitOfWork unitOfWork, IAuthService authService) : base(unitOfWork, authService)
        {
            _OTRequestRepository = unitOfWork.OTRequest;
            _userRepository = unitOfWork.User;
            _systemRepository = unitOfWork.System;
        }

        public async Task<ApiResponse> CreateOTRequest(CreateOTRequestModel model)
        {
            var U = _authService.User;
            if (!U.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }
            if (model.FromDate > model.ToDate)
            {
                return ApiResponse.BadRequest();
            }

            var isDuplicate = _OTRequestRepository.Contains(x => x.FromDate <= model.FromDate && x.ToDate >= model.ToDate && x.UserId == U.Id && !x.IsDeleted);
            if (isDuplicate)
            {
                return ApiResponse.BadRequest(RequestMessageConst.Duplicate);
            }

            var request = new OTRequest
            {
                Id = Guid.NewGuid(),
                FromDate = model.FromDate,
                ToDate = model.ToDate,
                UserId = U.Id,
                TimeOT = model.TimeOT,
                Status = OTRequestStatus.WAITING
            };
            _OTRequestRepository.Add(request);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> GetListOTRequest()
        {
            var U = _authService.User;
            if (!U.IsEmployee && !U.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            var requests = new List<ListOTRequestItem>();
            if (U.IsEmployee)
            {
                requests = _OTRequestRepository.GetMany(x => !x.IsDeleted && x.UserId == U.Id)
                    .Join(_userRepository.GetMany(x => x.Id == U.Id), x => x.UserId, y => y.Id, (x, y) => new ListOTRequestItem
                    {
                        RequestId = x.Id,
                        FromDate = x.FromDate.ToShortDateString(),
                        ToDate = x.ToDate.ToShortDateString(),
                        TimeOT = x.TimeOT,
                        Status = x.Status,
                        User = new UserDisplayInfo
                        {
                            Id = y.Id,
                            Fullname = y.Fullname,
                            Username = y.Username
                        }
                    }).ToList();
            }
            else
            {
                requests = _userRepository.GetMany(x => x.Id == U.Id)
                    .Join(_systemRepository.GetAll(), x => x.SystemId, y => y.Id, (x, y) => new { systemId = y.Id })
                    .Join(_userRepository.GetAll(), x => x.systemId, y => y.SystemId, (x, y) => new { UserId = y.Id, y.Username, y.Fullname })
                    .Join(_OTRequestRepository.GetMany(x => !x.IsDeleted), x => x.UserId, y => y.UserId, (x, y) => new ListOTRequestItem
                    {
                        RequestId = y.Id,
                        FromDate = y.FromDate.ToShortDateString(),
                        ToDate = y.ToDate.ToShortDateString(),
                        TimeOT = y.TimeOT,
                        Status = y.Status,
                        User = new UserDisplayInfo
                        {
                            Id = x.UserId,
                            Username = x.Username,
                            Fullname = x.Fullname
                        }
                    }).ToList();
            }

            return ApiResponse.OK(requests);
        }

        public async Task<ApiResponse> UpdateOTRequest(UpdateOTRequestModel model)
        {
            if (!_authService.User.IsLineManager && !_authService.User.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            var request = _OTRequestRepository.FirstOrDefault(x => x.Id == model.RequestId);
            if (request == null)
            {
                return ApiResponse.NotFound();
            }

            request.Status = model.Status ??= request.Status;
            _OTRequestRepository.Update(request);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

    }
}
