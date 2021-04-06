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
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Utilities.Constants;
using Utilities.Helper;

namespace Application.Implementations
{
    public class DayOffService : BaseService, IDayOffService
    {
        private IDayOffRequestRepository _dayOffRequestRepository;
        private IUserRepository _userRepository;
        private ISystemRepository _systemRepository;

        public DayOffService(IUnitOfWork unitOfWork, IAuthService authService) : base(unitOfWork, authService)
        {
            _dayOffRequestRepository = unitOfWork.DayOffRequest;
            _userRepository = unitOfWork.User;
            _systemRepository = unitOfWork.System;
        }

        public async Task<ApiResponse> CreateDayOffRequest(CreateDayOffRequestModel model)
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

            var isDuplicate = _dayOffRequestRepository.Contains(x => x.FromDate <= model.FromDate && x.ToDate >= model.ToDate && x.UserId == U.Id && !x.IsDeleted);
            if (isDuplicate)
            {
                return ApiResponse.BadRequest(RequestMessageConst.Duplicate);
            }

            var request = new DayOffRequest
            {
                Id = Guid.NewGuid(),
                FromDate = model.FromDate,
                ToDate = model.ToDate,
                UserId = U.Id,
                Status = DayOffRequestStatus.WAITING
            };
            _dayOffRequestRepository.Add(request);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

        public async Task<ApiResponse> GetListDayOffRequest()
        {
            var U = _authService.User;
            if (!U.IsEmployee && !U.IsLineManager)
            {
                return ApiResponse.Forbidden();
            }

            var requests = new List<ListDayOffRequestItem>();
            if (U.IsEmployee)
            {
                requests = _dayOffRequestRepository.GetMany(x => !x.IsDeleted && x.UserId == U.Id)
                    .Join(_userRepository.GetMany(x => x.Id == U.Id), x => x.UserId, y => y.Id, (x, y) => new ListDayOffRequestItem
                    {
                        RequestId = x.Id,
                        FromDate = x.FromDate.ToShortDateString(),
                        ToDate = x.ToDate.ToShortDateString(),
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
                    .Join(_dayOffRequestRepository.GetMany(x => !x.IsDeleted), x => x.UserId, y => y.UserId, (x, y) => new ListDayOffRequestItem
                    {
                        RequestId = y.Id,
                        FromDate = y.FromDate.ToShortDateString(),
                        ToDate = y.ToDate.ToShortDateString(),
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

        public async Task<ApiResponse> UpdateDayOffRequest(UpdateDayOffRequestModel model)
        {
            if (!_authService.User.IsLineManager && !_authService.User.IsEmployee)
            {
                return ApiResponse.Forbidden();
            }

            var request = _dayOffRequestRepository.FirstOrDefault(x => x.Id == model.RequestId);
            if (request == null)
            {
                return ApiResponse.NotFound();
            }

            request.Status = model.Status ??= request.Status;
            _dayOffRequestRepository.Update(request);
            await _unitOfWork.SaveChanges();

            return ApiResponse.OK();
        }

    }
}
